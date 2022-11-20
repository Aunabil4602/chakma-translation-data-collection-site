package chakma.translation.datacollection.translation.helper;

import chakma.translation.datacollection.translation.model.Answer;
import chakma.translation.datacollection.translation.model.QACommand;
import chakma.translation.datacollection.translation.model.Question;
import chakma.translation.datacollection.translation.service.AnswerRepository;
import chakma.translation.datacollection.translation.service.QuestionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * @author aunabil.chakma
 * @since 09/26/2022
 **/
@Component
public class Manager {

    private static Map<Integer, Integer> counts;
    private static List<Question> questionList;
    private static List<Question> samples;
    private static AtomicInteger currentIndex;
    private static final int sampleSize = 5;
    private static boolean isLoaded = false;
    private static AtomicInteger totalSubmissions;

    @Autowired
    private QuestionRepository questionRepository;

    @Autowired
    private AnswerRepository answerRepository;

    public QACommand getNextQA() {
        QACommand command = new QACommand(getNextAnswer());
        command.setTotalSubmission(totalSubmissions.get());
        return command;
    }

    private Answer getNextAnswer() {
        Answer answer = new Answer();
        answer.setQuestion(getNextQuestion());
        return answer;
    }

    synchronized private Question getNextQuestion() {
        if (currentIndex.get() >= sampleSize || samples == null || samples.isEmpty()) {
            createSample();
        }

        return samples.get(currentIndex.getAndIncrement());
    }

    /*called once at springboot start*/
    public void load() {
        if (isLoaded) {
            return;
        }

        questionList = Collections.synchronizedList(new ArrayList<>());
        counts = Collections.synchronizedMap(new HashMap<>());
        totalSubmissions = new AtomicInteger();
        currentIndex = new AtomicInteger();
        currentIndex.set(0);
        totalSubmissions.set(0);

        List<Question> questionListDb = questionRepository.findAll();
        questionListDb.forEach(q -> {
            questionList.add(q);
            counts.put(q.getId(), 0);
        });

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
        currentIndex.set(0);
    }

    public void increment(Question question) {
        Integer qid = (int) question.getId();
        Integer currentCount = counts.get(qid);
        currentCount++;
        counts.put(qid, currentCount);
        totalSubmissions.incrementAndGet();
    }

    public int getTotalSubmissions() {
        return totalSubmissions.get();
    }
}
