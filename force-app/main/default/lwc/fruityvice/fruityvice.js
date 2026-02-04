import { LightningElement } from 'lwc';

export default class Fruityvice extends LightningElement {

    step = 1;
    fruitId;
    showDetails = false;
    isModalOpen = false;

    get isFirstStep(){
        return this.step == 1;
    }

    get isSecondStep(){
        return this.step == 2;
    } 

    handleSelectFruit(event){
        const fruitId = event.detail;
        console.log(`fruit id: ${fruitId}`);
        if(fruitId){
            this.fruitId = fruitId;
            this.step = 2;
        }
    }

    previousStep(){
        if(this.step == 2){
        this.step--;
        this.showDetails = false;
        }
    }

    abrirModal(){
        this.isModalOpen = true;
    }

    onModalCancel(){
        this.isModalOpen = false;
        this.previousStep();
    }

    onModalSave(){
        this.isModalOpen = false;
    }
}