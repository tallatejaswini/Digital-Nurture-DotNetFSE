import React from "react";

function ListofPlayers() {

    const players = [
        { name: "Virat Kohli", score: 95 },
        { name: "Rohit Sharma", score: 85 },
        { name: "KL Rahul", score: 60 },
        { name: "Hardik Pandya", score: 75 },
        { name: "Shubman Gill", score: 45 },
        { name: "Ravindra Jadeja", score: 55 },
        { name: "Rishabh Pant", score: 80 },
        { name: "Mohammed Shami", score: 30 },
        { name: "Jasprit Bumrah", score: 65 },
        { name: "Kuldeep Yadav", score: 72 },
        { name: "Mohammed Siraj", score: 40 }
    ];

    const below70 = players.filter(player => player.score < 70);

    return (

        <div>

            <h1>List of Players</h1>

            <h3>All Players</h3>

            <ul>

                {
                    players.map((player, index) => (

                        <li key={index}>
                            {player.name} - {player.score}
                        </li>

                    ))
                }

            </ul>

            <h3>Players with Score Below 70</h3>

            <ul>

                {
                    below70.map((player, index) => (

                        <li key={index}>
                            {player.name} - {player.score}
                        </li>

                    ))
                }

            </ul>

        </div>

    );

}

export default ListofPlayers;