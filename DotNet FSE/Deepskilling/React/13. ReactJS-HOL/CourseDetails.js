import React from "react";


function CourseDetails()
{

    const courses = [

        {
            id:101,
            name:"React JS",
            duration:"2 Months"
        },

        {
            id:102,
            name:"Python Programming",
            duration:"3 Months"
        },

        {
            id:103,
            name:"Data Science",
            duration:"6 Months"
        }

    ];


    return(

        <div>


            <h2>Course Details</h2>


            <ul>

            {
                courses.map((course)=>

                    <li key={course.id}>

                        {course.name}
                        -
                        {course.duration}

                    </li>

                )
            }

            </ul>


        </div>

    );

}


export default CourseDetails;