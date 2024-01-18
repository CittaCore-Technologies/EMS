import { LightningElement,track } from 'lwc';

export default class JestTestForDataBindingWithEvents extends LightningElement {
    @track greeting = 'World';

    handleChange(event) {
        this.greeting = event.target.value;
    }
}