package com.springboot.springboot.project.pokemon;

import java.util.List;

public interface PokemonService {
  void pokemonDelete();
  void pokemonInsert(PokemonVO vo);

  List<PokemonVO> getPokemonList(PokemonVO vo);
  int getTotalCount(PokemonVO vo);
}
