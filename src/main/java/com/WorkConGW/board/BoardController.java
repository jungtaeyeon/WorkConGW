package com.WorkConGW.board;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/board")
public class BoardController {

    @GetMapping("/registForm")
    public String registForm(BoardFormVO boardFormVO)
    {
        String url = "board/registForm";

        return url;
    }
	
}
