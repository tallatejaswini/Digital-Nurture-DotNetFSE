import React, { useState } from "react";
import "./App.css";

function App() {

  const [isLoggedIn, setIsLoggedIn] = useState(false);


  // Guest Component
  const GuestPage = () => {
    return (
      <div>
        <h2>Welcome Guest User</h2>

        <h3>Available Flights</h3>

        <table>
          <tbody>
            <tr>
              <th>Flight</th>
              <th>From</th>
              <th>To</th>
              <th>Price</th>
            </tr>

            <tr>
              <td>Air India AI101</td>
              <td>Hyderabad</td>
              <td>Delhi</td>
              <td>₹5000</td>
            </tr>

            <tr>
              <td>Indigo 6E202</td>
              <td>Bangalore</td>
              <td>Mumbai</td>
              <td>₹4500</td>
            </tr>

          </tbody>
        </table>

        <p>
          Please login to book tickets.
        </p>

      </div>
    );
  };


  // User Component
  const UserPage = () => {
    return (
      <div>

        <h2>Welcome Logged In User</h2>

        <h3>Book Your Flight Ticket</h3>

        <form>

          <label>
            Passenger Name:
          </label>

          <input type="text" />

          <br/><br/>

          <label>
            Select Flight:
          </label>

          <select>
            <option>Air India AI101</option>
            <option>Indigo 6E202</option>
          </select>

          <br/><br/>

          <button>
            Book Ticket
          </button>

        </form>

      </div>
    );
  };


  // Element Variable for Conditional Rendering
  let page;

  if(isLoggedIn)
  {
    page = <UserPage />;
  }
  else
  {
    page = <GuestPage />;
  }


  return (

    <div className="container">

      <h1>Flight Ticket Booking Application</h1>


      {
        isLoggedIn ?

        <button onClick={() => setIsLoggedIn(false)}>
          Logout
        </button>

        :

        <button onClick={() => setIsLoggedIn(true)}>
          Login
        </button>

      }


      <hr/>


      {page}


    </div>

  );
}


export default App;