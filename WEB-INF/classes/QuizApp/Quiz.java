package QuizApp;

import java.util.HashMap;

public class Quiz {

    public int Quiz_id;
    public String Subject;
    public String Start_date;
    public String end_date;
    public String Created_time;
    public int duration;
    public int Total_Questions;
    public int Created_by;
	public Quiz()
	{
	}
    public HashMap<Integer, Question> Questions = new HashMap();
    public Quiz(int Quiz_id, String Subject, String Start_date, String End_date, String Created_time, int duration, int Total_Questions, int Created_by){
        this.Quiz_id = Quiz_id;
        this.Subject = Subject;
        this.Start_date = Start_date;
        this.end_date = end_date;
        this.Created_time = Created_time;
        this.duration = duration;
        this.Total_Questions = Total_Questions;
        this.Quiz_id = Created_by;

    }

}
