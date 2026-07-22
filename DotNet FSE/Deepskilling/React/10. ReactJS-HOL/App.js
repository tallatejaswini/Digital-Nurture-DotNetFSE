import React from "react";

function App() {

  const office = {
    Name: "DBS",
    Rent: 50000,
    Address: "Chennai"
  };

  const officeList = [
    {
      Name: "DBS",
      Rent: 50000,
      Address: "Chennai"
    },
    {
      Name: "Regus",
      Rent: 75000,
      Address: "Bangalore"
    },
    {
      Name: "WeWork",
      Rent: 65000,
      Address: "Hyderabad"
    }
  ];

  return (

    <div style={{ margin: "30px" }}>

      <h1>Office Space Rental App</h1>

      <img
        src="https://images.unsplash.com/photo-1497366754035-f200968a6e72?w=700"
        alt="Office Space"
        width="500"
        height="300"
      />

      <h2>Single Office Details</h2>

      <h3>Name : {office.Name}</h3>

      <h3
        style={{
          color: office.Rent < 60000 ? "red" : "green"
        }}
      >
        Rent : Rs. {office.Rent}
      </h3>

      <h3>Address : {office.Address}</h3>

      <hr />

      <h2>Office Space List</h2>

      {

        officeList.map((item, index) => (

          <div key={index} style={{
            border: "1px solid black",
            padding: "10px",
            marginBottom: "10px",
            width: "400px"
          }}>

            <h3>Name : {item.Name}</h3>

            <h3
              style={{
                color: item.Rent < 60000 ? "red" : "green"
              }}
            >
              Rent : Rs. {item.Rent}
            </h3>

            <h3>Address : {item.Address}</h3>

          </div>

        ))

      }

    </div>

  );

}

export default App;