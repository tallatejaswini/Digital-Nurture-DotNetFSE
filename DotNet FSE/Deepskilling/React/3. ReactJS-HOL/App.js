import React from "react";
import CalculateScore from "./Components/CalculateScore";

function App() {

    return (

        <div>

            <CalculateScore
                Name="Jyothirmai"
                School="VFSTR"
                Total={540}
                Goal={6}
            />

        </div>

    );

}

export default App;