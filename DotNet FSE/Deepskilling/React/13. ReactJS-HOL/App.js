import React, {useState} from "react";

import BookDetails from "./BookDetails";

import BlogDetails from "./BlogDetails";

import CourseDetails from "./CourseDetails";

import "./App.css";


function App()
{

    const [showBook,setShowBook]=useState(true);

    const [showBlog,setShowBlog]=useState(true);

    const [showCourse,setShowCourse]=useState(true);



    return(

        <div className="container">


            <h1>Blogger Application</h1>


            <button onClick={()=>setShowBook(!showBook)}>
                Show/Hide Books
            </button>


            <button onClick={()=>setShowBlog(!showBlog)}>
                Show/Hide Blogs
            </button>


            <button onClick={()=>setShowCourse(!showCourse)}>
                Show/Hide Courses
            </button>



            <hr/>


            {
                showBook && <BookDetails/>
            }



            {
                showBlog && <BlogDetails/>
            }



            {
                showCourse ? 
                <CourseDetails/> 
                :
                <h3>Course details hidden</h3>
            }



        </div>

    );

}


export default App;