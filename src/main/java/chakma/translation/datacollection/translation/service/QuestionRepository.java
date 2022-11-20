package chakma.translation.datacollection.translation.service;

import chakma.translation.datacollection.translation.model.Question;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * @author aunabil.chakma
 * @since 11/15/2022
 **/
@Repository
public interface QuestionRepository extends JpaRepository<Question, Integer> {
}
