﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuizAppV2
{
    internal class Question
    {
        public string QuestionText { get; set; }
        public string[] Options { get; set; }

        public int CorrectOptionIndex { get; set; }

        public Question(string questionText, string[] options,int correctOptionsIndex)
        {
         
            QuestionText = questionText;
            Options = options;
            CorrectOptionIndex = correctOptionsIndex;
        }

        public bool IsCorrect(int selectedOptionIndex)
        {
            return selectedOptionIndex == CorrectOptionIndex;
        }
    }
}
