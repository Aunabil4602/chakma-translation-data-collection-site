package chakma.translation.datacollection.Error;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import java.util.Collections;

/**
 * @author aunabil.chakma
 * @since 11/10/2022
 **/
@RestController
public class ErrorImplController implements ErrorController {

    private static final String PATH = "/error";

    @RequestMapping(value = PATH)
    public String error(HttpServletRequest request) {
        return "Error!!";
    }
}
