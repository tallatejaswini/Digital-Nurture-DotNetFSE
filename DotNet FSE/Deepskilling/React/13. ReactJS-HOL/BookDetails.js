import React from "react";


function BookDetails()
{

    const books = [
        {
            id:1,
            name:"Artificial Intelligence",
            author:"Russell Norvig"
        },

        {
            id:2,
            name:"Clean Code",
            author:"Robert Martin"
        },

        {
            id:3,
            name:"Java Programming",
            author:"Herbert Schildt"
        }
    ];


    return(

        <div>

            <h2>Book Details</h2>

            {
                books.map((book)=>(

                    <div key={book.id}>

                        <h3>{book.name}</h3>

                        <p>
                            Author : {book.author}
                        </p>

                    </div>

                ))
            }


        </div>

    );

}


export default BookDetails;