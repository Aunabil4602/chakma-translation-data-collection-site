package chakma.translation.datacollection.Experiment;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @author aunabil.chakma
 * @since 11/10/2022
 **/
@Controller
public class ExperimentController {

    @GetMapping("/jsp")
    public String getJSP() {
        return "hello";
    }

    @ResponseBody
    @RequestMapping("/json")
    public String getJson() {
        return "hello json!!";
    }
}
