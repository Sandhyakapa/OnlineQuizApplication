package QuizApp;

public class Question {
   public String question;
    public String Option_A;
    public String Option_B;
    public String Option_C;
    public String Option_D;
    public Character Correct_Answer;
	public Question(){}
    public Question(String question, String Option_A, String Option_B, String Option_C, String Option_D, Character Correct_Answer){
        this.question = question;
        this.Option_A = Option_A;
        this.Option_B = Option_B;
        this.Option_C = Option_C;
        this.Option_D = Option_D;
        this.Correct_Answer = Correct_Answer;

    }


}
