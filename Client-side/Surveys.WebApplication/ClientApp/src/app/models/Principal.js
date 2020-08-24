"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Principal = void 0;
var Principal = /** @class */ (function () {
    function Principal(init) {
        Object.assign(this, init);
    }
    Principal.ToListOfInstance = function (list) {
        return list.map(function (item) { return new Principal(item); });
    };
    Principal.ToInstance = function (item) {
        return new Principal(item);
    };
    return Principal;
}());
exports.Principal = Principal;
//# sourceMappingURL=Principal.js.map