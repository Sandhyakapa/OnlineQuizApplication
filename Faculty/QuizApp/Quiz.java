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
    //int Subject_ID;

   HashMap<Integer,Question> Questions;
    public Quiz(int Quiz_id, String Subject, String Start_date, String end_date, 
    String Created_time, int duration,int Total_Questions, int Created_by){
        this.Quiz_id = Quiz_id;
        this.Subject = Subject;
        this.Start_date = Start_date;
        this.end_date = end_date;
        this.Created_time = Created_time;
        this.duration = duration;
        this.Total_Questions = Total_Questions;
        this.Quiz_id = Created_by;
       // this.Subject_ID = Subject_ID;

    }

    public int getQuiz_id() { return Quiz_id; }
    public String getStart_date() { return Start_date; }
    public String getEnd_date() { return end_date; }
    public String getSubject() { return Subject; }
    public int getDuration() { return duration; }
    public int getTotal_Questions() { return Total_Questions; }

    /*public int getQuiz_id() {
        return Quiz_id;
    }

    public void setQuiz_id(int Quiz_id) {
        this.Quiz_id = Quiz_id;
    }

    public String getSubject() {
        return Subject;
    }

    public void setSubject(String Subject) {
        this.Subject = Subject;
    }

    public String getStart_date() {
        return Start_date;
    }

    public void setStart_date(String Start_date) {
        this.Start_date = Start_date;
    }

    public String getEnd_date() {
        return end_date;
    }

    public void setEnd_date(String end_date) {
        this.end_date = end_date;
    }

    public String getCreated_time() {
        return Created_time;
    }

    public void setCreated_time(String Created_time) {
        this.Created_time = Created_time;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public int getTotal_Questions() {
        return Total_Questions;
    }

    public void setTotal_Questions(int Total_Questions) {
        this.Total_Questions = Total_Questions;
    }

    public int getCreated_by() {
        return Created_by;
    }

    public void setCreated_by(int Created_by) {
        this.Created_by = Created_by;
    }

    public HashMap<Integer, Question> getQuestions() {
        return Questions;
    }*/

}
