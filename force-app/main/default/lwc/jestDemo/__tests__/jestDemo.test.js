import {createElement} from 'lwc';
import jestDemoComponent from 'c/jestDemo';


describe('Testes positivos', () => {
    beforeEach(() => {
        const jestDemo = createElement('c-jest-demo', {is: jestDemoComponent})
        document.body.appendChild(jestDemo);
    })

    afterEach(() => {
        while(document.body.firstChild){
            document.body.removeChild(document.body.firstChild);
        }
    })

    test('paragraph bind variable', () => {
        const component = document.querySelector('c-jest-demo');
        const paragraph = component.shadowRoot.querySelector('p');
        expect(paragraph.textContent).toBe('Olá mundo!')
    })

    test('conditional rendering test', async () => {
        const component = document.querySelector('c-jest-demo');
        let newParagraph = component.shadowRoot.querySelector('.newParagraph');
        expect(newParagraph).toBeNull();
        const button = component.shadowRoot.querySelector('lightning-button');
        button.dispatchEvent(new CustomEvent('click'));

        await Promise.resolve();

        newParagraph = component.shadowRoot.querySelector('.newParagraph');
        expect(newParagraph.textContent).toBe('Wow I love Tacos');
        
    })
})