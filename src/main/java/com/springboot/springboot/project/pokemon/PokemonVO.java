package com.springboot.springboot.project.pokemon;

import org.jsoup.nodes.Element;

import lombok.Data;

@Data
public class PokemonVO {
    Element title;
    String num;
    String name;
    String image;
    String type1;
    String type2;

    String ch1;
    String ch2;

    int start;
    int pageSize;
    int end;
}
