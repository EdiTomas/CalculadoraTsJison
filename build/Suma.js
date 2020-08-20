"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
class Suma {
    constructor(hijo1, hijo3, linea, columna) {
        this.hijo1 = hijo1;
        this.hijo3 = hijo3;
        this.linea = linea;
        this.columna = columna;
    }
    ejecutar() {
        return Number(this.hijo1.ejecutar()) + Number(this.hijo3.ejecutar());
    }
}
exports.Suma = Suma;
