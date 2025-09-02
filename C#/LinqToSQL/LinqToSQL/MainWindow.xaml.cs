﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace LinqToSQL
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        LinqToSQLClassesDataContext dataContext;
        public MainWindow()
        {
            InitializeComponent();

            string connectionString = ConfigurationManager.ConnectionStrings["LinqToSQL.Properties.Settings.CSharpUdemyDBConnectionString"].ConnectionString;
            dataContext = new LinqToSQLClassesDataContext(connectionString);

            //InsertUniversities();
            //InsertStudent();
            //InsertLectures();
            //InsertStudentLectureAssociations();
            //GetUniversityOfToni();
            //GetLecturesFromToni();
            //GetAllStudentsFromYale();
            //GetAllUniversitiesWithTransgenders();
            //GetAllLecturesFromBeijingTech();
            //UpdateToni();
            DeleteJame();
        }

        public void InsertUniversities()
        {
           dataContext.ExecuteCommand("delete from University");

            University yale = new University();
            yale.Name = "Yale";
            dataContext.Universities.InsertOnSubmit(yale);

            University beijingTech = new University();
            beijingTech.Name = "Beijing Tech";
            dataContext.Universities.InsertOnSubmit(beijingTech);

            dataContext.SubmitChanges();

            MainDataGrid.ItemsSource = dataContext.Universities;
        }

        public void InsertStudent()
        {
            dataContext.ExecuteCommand("delete from Student");

            University yale = dataContext.Universities.First(un => un.Name.Equals("Yale"));
            University beijingTech = dataContext.Universities.First(un => un.Name.Equals("Beijing Tech"));

            List<Student> students = new List<Student>();

            students.Add(new Student { Name = "Carla", Gender = "female", UniversityID = yale.Id });
            students.Add(new Student { Name = "Toni", Gender = "male", University = yale });
            students.Add(new Student { Name = "Leyle", Gender = "female", University = beijingTech });
            students.Add(new Student { Name = "Jame", Gender = "trans-gender", University = beijingTech });

            dataContext.Students.InsertAllOnSubmit(students);
            dataContext.SubmitChanges();

            MainDataGrid.ItemsSource = dataContext.Students;

        }

        public void InsertLectures()
        {
            dataContext.Lectures.InsertOnSubmit(new Lecture { Name = "CompSci" });
            dataContext.Lectures.InsertOnSubmit(new Lecture { Name = "Math" });

            dataContext.SubmitChanges();

            MainDataGrid.ItemsSource = dataContext.Lectures;
        }

        public void InsertStudentLectureAssociations()
        {
            Student Carla = dataContext.Students.First(st => st.Name.Equals("Carla"));
            Student Toni = dataContext.Students.First(st => st.Name.Equals("Toni"));
            Student Leyle = dataContext.Students.First(st => st.Name.Equals("Leyle"));
            Student Jame = dataContext.Students.First(st => st.Name.Equals("Jame"));

            Lecture CompSci = dataContext.Lectures.First(lc => lc.Name.Equals("CompSci"));
            Lecture Math = dataContext.Lectures.First(lc => lc.Name.Equals("Math"));

            dataContext.StudentLectures.InsertOnSubmit(new StudentLecture { Student = Carla, Lecture = Math });
            dataContext.StudentLectures.InsertOnSubmit(new StudentLecture { Student = Toni, Lecture = Math });

            StudentLecture slToni = new StudentLecture();
            slToni.StudentId = Toni.Id;
            slToni.LectureId = CompSci.Id;
            dataContext.StudentLectures.InsertOnSubmit(slToni);

            dataContext.StudentLectures.InsertOnSubmit(new StudentLecture { Student = Leyle, Lecture = CompSci });

            dataContext.SubmitChanges();

            MainDataGrid.ItemsSource = dataContext.StudentLectures;
        }

        public void GetUniversityOfToni()
        {
            Student Toni = dataContext.Students.First(st => st.Name.Equals("Toni"));

            University TonisUniversity = Toni.University;

            List<University> universities = new List<University>();
            universities.Add(TonisUniversity);

            MainDataGrid.ItemsSource = universities;

        }

        public void GetLecturesFromToni()
        {
            Student Toni = dataContext.Students.First(st => st.Name.Equals("Toni"));

            var tonisLectures = from sl in Toni.StudentLectures select sl.Lecture;

            MainDataGrid.ItemsSource = tonisLectures;
        }

        public void GetAllStudentsFromYale()
        {
            var studentsFromYale = from student in dataContext.Students
                                   where student.University.Name == "Yale"
                                   select student;

            MainDataGrid.ItemsSource = studentsFromYale;
        }

        public void GetAllUniversitiesWithTransgenders()
        {
            var transgernderUniversities = from student in dataContext.Students
                                           join university in dataContext.Universities
                                           on student.University equals university
                                           where student.Gender == "trans-gender"
                                           select university;

            MainDataGrid.ItemsSource = transgernderUniversities;
        }

        public void GetAllLecturesFromBeijingTech()
        {
            var lecturesFromBeijingTech = from sl in dataContext.StudentLectures
                                          join student in dataContext.Students on sl.StudentId equals student.Id
                                          where student.University.Name == "Beijing Tech"
                                          select sl.Lecture;

            MainDataGrid.ItemsSource = lecturesFromBeijingTech;
        }

        public void UpdateToni()
        {
            Student Toni = dataContext.Students.FirstOrDefault(st => st.Name == "Toni");

            Toni.Name = "Antonio";

            dataContext.SubmitChanges();

            MainDataGrid.ItemsSource = dataContext.Students;
        }

        public void DeleteJame()
        {
            Student Jame = dataContext.Students.FirstOrDefault(st => st.Name == "Jame");
            dataContext.Students.DeleteOnSubmit(Jame);
            dataContext.SubmitChanges();

            MainDataGrid.ItemsSource = dataContext.Students;
        }
    }
}
