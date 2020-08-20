"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
class menos {
    constructor(hijo1, linea, columna) {
        this.hijo1 = hijo1;
        this.linea = linea;
        this.columna = columna;
    }
    ejecutar() {
        return -Number(this.hijo1.ejecutar());
    }
}
exports.menos = menos;
