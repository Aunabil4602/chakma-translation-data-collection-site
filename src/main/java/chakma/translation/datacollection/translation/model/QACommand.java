package chakma.translation.datacollection.translation.model;

/**
 * @author aunabil.chakma
 * @since 09/26/2022
 **/
public class QACommand {

    private Answer answer;

    private int totalSubmission = 0;

    public QACommand(Answer answer) {
        this.answer = answer;
    }

    public Answer getAnswer() {
        return answer;
    }

    public void setAnswer(Answer answer) {
        this.answer = answer;
    }

    public int getTotalSubmission() {
        return totalSubmission;
    }

    public void setTotalSubmission(int totalSubmission) {
        this.totalSubmission = totalSubmission;
    }
}
