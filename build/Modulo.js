"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
class Modulo {
    constructor(hijo1, hijo3, linea, columna) {
        this.hijo1 = hijo1;
        this.hijo3 = hijo3;
        this.linea = linea;
        this.columna = columna;
    }
    ejecutar() {
        if (Number(this.hijo3.ejecutar()) == 0) {
            throw { error: "No se puede division entre cero", linea: this.linea, Columna: this.columna
            };
        }
        return Number(this.hijo1.ejecutar()) % Number(this.hijo3.ejecutar());
    }
}
exports.Modulo = Modulo;
