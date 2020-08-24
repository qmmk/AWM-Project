"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.RefreshToken = void 0;
var RefreshToken = /** @class */ (function () {
    function RefreshToken() {
        this.IsExpired = new Date() >= this.Expires;
        this.IsActive = this.Revoked == null && !this.IsExpired;
    }
    return RefreshToken;
}());
exports.RefreshToken = RefreshToken;
//# sourceMappingURL=RefreshToken.js.map