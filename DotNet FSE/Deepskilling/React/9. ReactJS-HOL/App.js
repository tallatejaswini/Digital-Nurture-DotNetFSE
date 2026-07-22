import React from "react";

import ListofPlayers from "./Components/ListofPlayers";
import IndianPlayers from "./Components/IndianPlayers";

function App() {

    const flag = false;

    if(flag){

        return <ListofPlayers/>;

    }

    else{

        return <IndianPlayers/>;

    }

}

export default App;