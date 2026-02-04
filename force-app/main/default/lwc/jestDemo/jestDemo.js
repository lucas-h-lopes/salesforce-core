import { LightningElement } from 'lwc';

export default class JestDemo extends LightningElement {
    variavel = 'Olá mundo!'
    showNewParagraph = false;

    renderNewParagraph(){
        this.showNewParagraph = !this.showNewParagraph;
    }
}