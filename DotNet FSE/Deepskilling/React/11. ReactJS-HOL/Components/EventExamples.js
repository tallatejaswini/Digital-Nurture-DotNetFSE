import React, { Component } from "react";

class EventExamples extends Component {

    constructor(props) {
        super(props);

        this.state = {
            counter: 0
        };
    }

    increment = () => {

        this.setState({
            counter: this.state.counter + 1
        });

    };

    decrement = () => {

        this.setState({
            counter: this.state.counter - 1
        });

    };

    sayHello = () => {

        alert("Hello! Static Message");

    };

    incrementCounter = () => {

        this.increment();
        this.sayHello();

    };

    sayWelcome = (msg) => {

        alert(msg);

    };

    onPress = () => {

        alert("I was clicked");

    };

    render() {

        return (

            <div>

                <h2>Counter : {this.state.counter}</h2>

                <button onClick={this.incrementCounter}>
                    Increment
                </button>

                &nbsp;

                <button onClick={this.decrement}>
                    Decrement
                </button>

                <br /><br />

                <button
                    onClick={() => this.sayWelcome("Welcome")}
                >
                    Say Welcome
                </button>

                <br /><br />

                <button onClick={this.onPress}>
                    OnPress
                </button>

            </div>

        );

    }

}

export default EventExamples;