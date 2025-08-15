////SIMPLE ARRAY
//int[] myIntArray = new int[5];
//// assigned values to the array
//myIntArray[0] = 5;
//myIntArray[1] = 12;
//myIntArray[2] = 13;
//myIntArray[3] = 14;
//myIntArray[4] = 15;

//Console.WriteLine(myIntArray[3]);

//Console.ReadKey();


//// Indexes [0][ 1][ 2][ 3][ 4]
//// content [5][12][13][14][15]

//--------------------------------------------------------------------------
//FOREACH
// declare an array and set the array element values
//int[] myIntArray = [1, 2, 3, 4, 5];

//string[] weekDays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

//Console.WriteLine("Lenght of the weekdays Array is: " + weekDays.Length);

////for (int i = 0; i < weekDays.Length; i++)
////{
////    Console.WriteLine(weekDays[i]);
////}

//foreach (string day in weekDays)
//{
//    Console.WriteLine(day);
//}


//Console.ReadKey();

//------------------------------------------------------------------------
//2D ARRAYS
//int[,] array2DDeclaration = new int[3, 3];
//// [0] [0] [0]
//// [0] [0] [0]
//// [0] [0] [0]

//int[,,] array3DDeclaration = new int[3, 3, 3];


//int[,] array2DInizilized = { { 1, 2 }, { 3, 4 } };
//// [1] [2]  // row 0
//// [3] [4]  // row 1

//string[,] ticTacToeField =
//{
//    {"O","X","X" },
//    {"O","O","X" },
//    {"X","X","O" }
//};

//string[,] understandingIndexes =
//{
//    {"0,0","0,1","0,2" },
//    {"1,0","1,1","1,2" },
//    {"2,0","2,1","2,2" }
//};

//Console.WriteLine(understandingIndexes[1, 2]);

//Console.ReadKey();

//---------------------------------------------------------------------
//3D ARRAYS

//int[,,] array3DDeclaration = new int[3, 3, 3];

//// initialized 3D Array
//string[,,] simple3DArray =
//{
//    {
//        {"000", "001"},
//        {"010", "011" }
//    },
//    {
//        {"100", "101"},
//        {"110", "111"}
//    },
//    {
//        {"200", "201"},
//        {"210", "211"}
//    }
//};

//// assign a value
//simple3DArray[2, 1, 0] = "Hi, what's up?";

//Console.WriteLine(simple3DArray[2, 1, 0]);

//-----------------------------------------------------------------------
////TRAVERSING EACH ROW ALONE IN 2D ARRAY
//int[,] arr = {{1,2,3},{4,5,6},{ 7,8,9}};

//for (int i = 0; i < arr.GetLength(0); i++)
//{
//    int sum = 0;
//    for(int j = 0; j < arr.GetLength(1); j++)
//    {
//        sum += arr[i, j];
//    }
//    Console.WriteLine(sum);
//}

//Console.ReadKey();