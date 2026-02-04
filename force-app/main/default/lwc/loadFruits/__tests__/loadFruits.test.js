import { createElement } from '@lwc/engine-dom'; 
import LoadFruits from 'c/loadFruits';
import getAllFruits from '@salesforce/apex/FruityviceController.getAllFruits';

const successMock = require('./data/success.json')
const errorMock = require('./data/error.json')

jest.mock('@salesforce/apex/FruityviceController.getAllFruits', () =>{
    const {
        createApexTestWireAdapter
    } = require('@salesforce/sfdx-lwc-jest');
    return {
        default: createApexTestWireAdapter(jest.fn())
    }
}, {virtual: true})

describe('c-load-fruits', () => {

    beforeEach(() => {
        const component = createElement('c-load-fruits', {
            is: LoadFruits
        })

        document.body.appendChild(component);
    })

    afterEach(() => {
        // The jsdom instance is shared across test cases in a single file so reset the DOM
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    it('Deverá carregar duas opções no select', async () => {
        const component = document.querySelector('c-load-fruits');

        getAllFruits.emit(successMock);

        await Promise.resolve();

        const select = component.shadowRoot.querySelector('.fruitSelect');

        expect(select.options.length).toBe(2);
    });

    it('Deverá carregar o componente c-error-panel caso o wire retorne erro', async () => {
        const component = document.querySelector('c-load-fruits');
        let error = component.shadowRoot.querySelector('c-error-panel');
        expect(error).toBeNull();

        getAllFruits.error(errorMock);

        await Promise.resolve();

        const select = component.shadowRoot.querySelector('.fruitSelect');
        error = component.shadowRoot.querySelector('c-error-panel');

        expect(select).toBeNull();
        expect(error.error.body.error).toBe('Not found')
        expect(error.error.status).toBe(400)
        expect(error.error.statusText).toBe('Bad Request')
    });

     it('Deverá lançar um evento do tipo `selectfruit` ao clicar no botão com dados válidos', async () => {
        const component = document.querySelector('c-load-fruits');

        getAllFruits.emit(successMock);

        await Promise.resolve();

        const select = component.shadowRoot.querySelector('.fruitSelect');
        select.value = '3';

        select.dispatchEvent(new CustomEvent('change'), {target: {value: '3'}})

        await Promise.resolve();

        const handler=  jest.fn();
        component.addEventListener('selectfruit', handler);

        const button = component.shadowRoot.querySelector('.prosseguir');
        button.dispatchEvent(new CustomEvent('click'));

        expect(handler).toHaveBeenCalledTimes(1);
        expect(handler.mock.calls[0][0].detail).toBe('3');
    });

    it('Deverá disparar um evento do tipo `ShowToastEvent` caso fruta não selecionada', async () => {
        const component = document.querySelector('c-load-fruits');

        getAllFruits.emit(successMock);
        await Promise.resolve();

        const spy = jest.spyOn(component, 'dispatchEvent');

        const button = component.shadowRoot.querySelector('.prosseguir');
        button.click();

        await Promise.resolve();

        expect(spy).toHaveBeenCalled();
        
        const event = spy.mock.calls[0][0];

        expect(event.detail.variant).toBe('error');
        expect(event.detail.title).toBe('Dados inválidos');
        expect(event.detail.message).toBe('Selecione uma fruta para prosseguir.');
    })

     it('Deverá disparar um evento do tipo `ShowToastEvent` caso fruta incorreta selecionada', async () => {
       const component = document.querySelector('c-load-fruits');

        getAllFruits.emit(successMock);

        await Promise.resolve();

        const select = component.shadowRoot.querySelector('.fruitSelect');
        select.value = '4';

        select.dispatchEvent(new CustomEvent('change'), {target: {value: '4'}})

        await Promise.resolve();

         const spy = jest.spyOn(component, 'dispatchEvent');

        const button = component.shadowRoot.querySelector('.prosseguir');
        button.click();

        await Promise.resolve();

        expect(spy).toHaveBeenCalled();
        
        const event = spy.mock.calls[0][0];

        expect(event.detail.variant).toBe('error');
        expect(event.detail.title).toBe('Dados inválidos');
        expect(event.detail.message).toBe('Selecione uma fruta para prosseguir.');
    })
});