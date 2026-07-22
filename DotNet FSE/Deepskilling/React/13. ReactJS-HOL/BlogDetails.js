import React from "react";


function BlogDetails()
{

    const isBlogAvailable = true;


    return(

        <div>

            <h2>Blog Details</h2>


            {
                isBlogAvailable ?

                <p>
                    Latest blogs are available.
                </p>

                :

                <p>
                    No blogs available.
                </p>

            }


        </div>

    );

}


export default BlogDetails;