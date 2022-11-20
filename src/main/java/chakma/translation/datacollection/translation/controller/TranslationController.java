package chakma.translation.datacollection.translation.controller;

import chakma.translation.datacollection.translation.helper.Manager;
import chakma.translation.datacollection.translation.model.Answer;
import chakma.translation.datacollection.translation.model.QACommand;
import chakma.translation.datacollection.translation.service.AnswerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * @author aunabil.chakma
 * @since 09/19/2022
 **/
@ControllerAdvice
@Controller
public class TranslationController {

    public static final String FN = "online_parallel_data_collections.txt";
    public static final String DOWNLOAD_TOKEN = "4897ad9198b41d6b81226a9d2a2327a2"; // md5 - aunabilchakmaamlan

    @Autowired
    private Manager manager;

    @Autowired
    private AnswerRepository answerRepository;

    @GetMapping(value = {"/", "/home"})
    public String home(Model model) {
        model.addAttribute("totalSubmission", manager.getTotalSubmissions());
        return "home";
    }

    @GetMapping(value = "/create")
    public String create(Model model) {
        model.addAttribute("command", manager.getNextQA());

        if (model.containsAttribute("success")) {
            model.addAttribute("success", true);
        }

        if (model.containsAttribute("another")) {
            model.addAttribute("another", true);
        }

        return "create";
    }

    @PostMapping(value = "/create", params = "save")
    public String postCreate(@ModelAttribute QACommand command, RedirectAttributes redirectAttributes) {
        answerRepository.save(command.getAnswer());
        manager.increment(command.getAnswer().getQuestion());
        redirectAttributes.addFlashAttribute("success", true);

        return "redirect:/create";
    }

    @GetMapping(value = "/new")
    public String newQuestion(RedirectAttributes redirectAttributes) {
        redirectAttributes.addFlashAttribute("another", true);

        return "redirect:/create";
    }

    @GetMapping(value = "/download")
    public void download(@RequestParam String token, HttpServletRequest request, HttpServletResponse response) {
        if (token.equals(DOWNLOAD_TOKEN)) {
            List<Answer> answerList = answerRepository.findAll();

            try {
                response.setContentType("application/txt");
                response.setCharacterEncoding("UTF-8");
                response.addHeader("Content-Disposition", "attachment; filename=" + FN);
                PrintWriter writer = response.getWriter();
                for (Answer answer : answerList) {
                    writer.write(answer.getQuestion().getDescription() + " @@@@@ " + answer.getDescription() + "\n");
                }
                writer.flush();
            } catch (IOException e) {
                System.out.println(e.getMessage());
            }
        }
    }

    @ResponseBody
    @GetMapping("/totalSubmissions")
    public String getTotalSubmission() {
        return String.valueOf(manager.getTotalSubmissions());
    }
}
