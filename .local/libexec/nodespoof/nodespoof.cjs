'use strict';

var os = require('os');
var path = require('path');
var FAKE = '22.20.0';
var FV = 'v' + FAKE;
var WRAP = process.env.__SPOOF_WRAPPER || path.join(os.homedir(), '.local', 'libexec', 'nodespoof', 'node');
try { Object.defineProperty(process, 'version', { value: FV, configurable: true, enumerable: true }); } catch (e) {}
try { Object.defineProperty(process.versions, 'node', { value: FAKE, configurable: true, enumerable: true }); } catch (e) {}
try { Object.defineProperty(process, 'execPath', { value: WRAP, configurable: true, enumerable: true }); } catch (e) {}
