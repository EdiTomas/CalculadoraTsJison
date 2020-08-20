import {Nodo} from './Nodo'
export class Valor implements Nodo{

    public hoja:Number;   
    constructor(hoja:Number){
         this.hoja =hoja;
    }
    ejecutar(){
         return this.hoja;
    }
}