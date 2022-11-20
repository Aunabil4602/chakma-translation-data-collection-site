package chakma.translation.datacollection.translation.helper;

import chakma.translation.datacollection.translation.model.Answer;
import chakma.translation.datacollection.translation.model.QACommand;
import chakma.translation.datacollection.translation.model.Question;
import chakma.translation.datacollection.translation.service.AnswerRepository;
import chakma.translation.datacollection.translation.service.QuestionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.*;

/**
 * @author aunabil.chakma
 * @since 09/26/2022
 **/
@Component
public class Manager {

    public static Map<Integer, Integer> counts;
    public static List<Question> questionList;
    public static List<Question> samples;
    public static int currentIndex = 0;
    public static final int sampleSize = 5;
    public static boolean isLoaded = false;
    private SynchronizedCounter totalSubmissions;

    @Autowired
    private QuestionRepository questionRepository;

    @Autowired
    private AnswerRepository answerRepository;

    public QACommand getNextQA() {
        QACommand command = new QACommand(getNextAnswer());
        command.setTotalSubmission(totalSubmissions.getValue());
        return command;
    }

    private Answer getNextAnswer() {
        Answer answer = new Answer();
        answer.setQuestion(getNextQuestion());
        return answer;
    }

    synchronized private Question getNextQuestion() {
        if (currentIndex >= sampleSize || samples == null || samples.isEmpty()) {
            createSample();
        }

        return samples.get(currentIndex++);
    }

    /*better not to call manually / work once at begining*/
    public void load() {
        if (isLoaded) {
            return;
        }

        // initialize
        questionList = Collections.synchronizedList(new ArrayList<>());
        counts = Collections.synchronizedMap(new HashMap<>());
        totalSubmissions = new SynchronizedCounter();

        // loading questions
        List<Question> questionListDb = questionRepository.findAll();
        questionListDb.forEach(q -> {
            questionList.add(q);
            counts.put(q.getId(), 0);
        });

        // loading answer stats
        List<Answer> answerListDb = answerRepository.findAll();
        answerListDb.forEach(a -> {
            increment(a.getQuestion());
        });

        isLoaded = true;
    }

    public void createSample() {
        questionList.sort((a, b) -> counts.get(a.getId()).compareTo(counts.get(b.getId())));
        samples = Collections.synchronizedList(new ArrayList<>());

        for (int i = 0; i < sampleSize; i++) {
            samples.add(questionList.get(i));
        }
        currentIndex = 0;
    }

    public void increment(Question question) {
        Integer qid = (int) question.getId();
        Integer currentCount = counts.get(qid);
        currentCount++;
        counts.put(qid, currentCount);
        totalSubmissions.increment();
    }

    private class SynchronizedCounter {
        private int c = 0;

        public synchronized void increment() {
            c++;
        }

        public synchronized int getValue() {
            return c;
        }
    }
}
