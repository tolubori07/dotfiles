"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.Formatter = void 0;
const child_process_1 = require("child_process");
const editorconfig = require("editorconfig");
const LSP = require("vscode-languageserver/node");
const logger_1 = require("../util/logger");
class Formatter {
    constructor({ cwd, executablePath }) {
        this._canFormat = true;
        this.cwd = cwd || process.cwd();
        this.executablePath = executablePath;
    }
    get canFormat() {
        return this._canFormat;
    }
    format(document, formatOptions, shfmtConfig) {
        return __awaiter(this, void 0, void 0, function* () {
            if (!this._canFormat) {
                return [];
            }
            return this.executeFormat(document, formatOptions, shfmtConfig);
        });
    }
    executeFormat(document, formatOptions, shfmtConfig) {
        return __awaiter(this, void 0, void 0, function* () {
            const result = yield this.runShfmt(document, formatOptions, shfmtConfig);
            if (!this._canFormat) {
                return [];
            }
            return [
                {
                    range: LSP.Range.create(LSP.Position.create(0, 0), LSP.Position.create(Number.MAX_VALUE, Number.MAX_VALUE)),
                    newText: result,
                },
            ];
        });
    }
    getShfmtArguments(documentUri, formatOptions, lspShfmtConfig) {
        return __awaiter(this, void 0, void 0, function* () {
            const args = [];
            // this is the config that we'll use to build args - default to language server config
            let activeShfmtConfig = Object.assign({}, lspShfmtConfig);
            // do we have a document stored on the local filesystem?
            const filepathMatch = documentUri.match(/^file:\/\/(.*)$/);
            if (filepathMatch) {
                const filepath = filepathMatch[1];
                args.push(`--filename=${filepathMatch[1]}`);
                if (!(lspShfmtConfig === null || lspShfmtConfig === void 0 ? void 0 : lspShfmtConfig.ignoreEditorconfig)) {
                    const editorconfigProperties = yield editorconfig.parse(filepath);
                    logger_1.logger.debug(`Shfmt: found .editorconfig properties: ${JSON.stringify(editorconfigProperties)}`);
                    const editorconfigShfmtConfig = {};
                    editorconfigShfmtConfig.binaryNextLine = editorconfigProperties.binary_next_line;
                    editorconfigShfmtConfig.caseIndent = editorconfigProperties.switch_case_indent;
                    editorconfigShfmtConfig.funcNextLine = editorconfigProperties.function_next_line;
                    editorconfigShfmtConfig.keepPadding = editorconfigProperties.keep_padding;
                    // --simplify is not supported via .editorconfig
                    editorconfigShfmtConfig.spaceRedirects = editorconfigProperties.space_redirects;
                    editorconfigShfmtConfig.languageDialect = editorconfigProperties.shell_variant;
                    // if we have any shfmt-specific options in .editorconfig, use the config in .editorconfig and
                    // ignore the language server config (this is similar to shfmt's approach of using either
                    // .editorconfig or command line flags, but not both)
                    if (editorconfigShfmtConfig.binaryNextLine !== undefined ||
                        editorconfigShfmtConfig.caseIndent !== undefined ||
                        editorconfigShfmtConfig.funcNextLine !== undefined ||
                        editorconfigShfmtConfig.keepPadding !== undefined ||
                        editorconfigShfmtConfig.spaceRedirects !== undefined ||
                        editorconfigShfmtConfig.languageDialect !== undefined) {
                        logger_1.logger.debug('Shfmt: detected shfmt properties in .editorconfig - ignoring language server shfmt config');
                        activeShfmtConfig = Object.assign({}, editorconfigShfmtConfig);
                    }
                    else {
                        logger_1.logger.debug('Shfmt: no shfmt properties found in .editorconfig - using language server shfmt config');
                    }
                }
                else {
                    logger_1.logger.debug('Shfmt: configured to ignore .editorconfig - using language server shfmt config');
                }
            }
            // indentation always comes via the editor - if someone is using .editorconfig then the
            // expectation is that they will have configured their editor's indentation in this way too
            const indentation = (formatOptions === null || formatOptions === void 0 ? void 0 : formatOptions.insertSpaces) ? formatOptions.tabSize : 0;
            args.push(`-i=${indentation}`); // --indent
            if (activeShfmtConfig === null || activeShfmtConfig === void 0 ? void 0 : activeShfmtConfig.binaryNextLine)
                args.push('-bn'); // --binary-next-line
            if (activeShfmtConfig === null || activeShfmtConfig === void 0 ? void 0 : activeShfmtConfig.caseIndent)
                args.push('-ci'); // --case-indent
            if (activeShfmtConfig === null || activeShfmtConfig === void 0 ? void 0 : activeShfmtConfig.funcNextLine)
                args.push('-fn'); // --func-next-line
            if (activeShfmtConfig === null || activeShfmtConfig === void 0 ? void 0 : activeShfmtConfig.keepPadding)
                args.push('-kp'); // --keep-padding
            if (activeShfmtConfig === null || activeShfmtConfig === void 0 ? void 0 : activeShfmtConfig.simplifyCode)
                args.push('-s'); // --simplify
            if (activeShfmtConfig === null || activeShfmtConfig === void 0 ? void 0 : activeShfmtConfig.spaceRedirects)
                args.push('-sr'); // --space-redirects
            if (activeShfmtConfig === null || activeShfmtConfig === void 0 ? void 0 : activeShfmtConfig.languageDialect)
                args.push(`-ln=${activeShfmtConfig.languageDialect}`); // --language-dialect
            return args;
        });
    }
    runShfmt(document, formatOptions, shfmtConfig) {
        return __awaiter(this, void 0, void 0, function* () {
            const args = yield this.getShfmtArguments(document.uri, formatOptions, shfmtConfig);
            logger_1.logger.debug(`Shfmt: running "${this.executablePath} ${args.join(' ')}"`);
            let out = '';
            let err = '';
            const proc = new Promise((resolve, reject) => {
                const proc = (0, child_process_1.spawn)(this.executablePath, [...args, '-'], { cwd: this.cwd });
                proc.on('error', reject);
                proc.on('close', resolve);
                proc.stdout.on('data', (data) => (out += data));
                proc.stderr.on('data', (data) => (err += data));
                proc.stdin.on('error', () => {
                    // NOTE: Ignore STDIN errors in case the process ends too quickly, before we try to
                    // write. If we write after the process ends without this, we get an uncatchable EPIPE.
                    // This is solved in Node >= 15.1 by the "on('spawn', ...)" event, but we need to
                    // support earlier versions.
                });
                proc.stdin.end(document.getText());
            });
            let exit;
            try {
                exit = yield proc;
            }
            catch (e) {
                if (e.code === 'ENOENT') {
                    // shfmt path wasn't found, don't try to format any more:
                    logger_1.logger.warn(`Shfmt: disabling formatting as no executable was found at path '${this.executablePath}'`);
                    this._canFormat = false;
                    return '';
                }
                throw new Error(`Shfmt: child process error: ${e}`);
            }
            if (exit != 0) {
                throw new Error(`Shfmt: exited with status ${exit}: ${err}`);
            }
            return out;
        });
    }
}
exports.Formatter = Formatter;
//# sourceMappingURL=index.js.map