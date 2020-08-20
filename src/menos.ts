import {Nodo} from './Nodo'
export class menos implements Nodo{

   public hijo1:Nodo;
   public linea:Number;
   public columna:Number;
   constructor(hijo1:Nodo,linea:Number,columna:Number){
          this.hijo1=hijo1
          this.linea=linea
          this.columna=columna 
            
   }   

   ejecutar(){
       return -Number(this.hijo1.ejecutar());
   }


}