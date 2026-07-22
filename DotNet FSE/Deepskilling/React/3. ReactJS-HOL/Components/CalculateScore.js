import React from "react";
import "../Stylesheets/mystyle.css";

function CalculateScore(props) {

    const average = props.Total / props.Goal;

    return (
        <div className="box">

            <h1>Student Score Calculator</h1>

            <h3>Name : {props.Name}</h3>

            <h3>School : {props.School}</h3>

            <h3>Total Marks : {props.Total}</h3>

            <h3>Number of Subjects : {props.Goal}</h3>

            <h2>Average Score : {average}</h2>

        </div>
    );
}

export default CalculateScore;