package QuizApp;
import java.util.HashMap;

public class Quiz {

    int Quiz_id;
    String Subject;
    String Start_date;
    String end_date;
    String Created_time;
    int duration;
    int Total_Questions;
    int Created_by;

   HashMap<Integer,Question> Questions;
    public Quiz(int Quiz_id, String Subject, String Start_date, String End_date, 
    String Created_time, int duration,int Total_Questions, int Created_by){
        this.Quiz_id = Quiz_id;
        this.Subject = Subject;
        this.Start_date = Start_date;
        this.end_date = End_date;
        this.Created_time = Created_time;
        this.duration = duration;
        this.Total_Questions = Total_Questions;
        this.Quiz_id = Created_by;

    }

}
