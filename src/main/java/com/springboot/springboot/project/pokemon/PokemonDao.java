package com.springboot.springboot.project.pokemon;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PokemonDao {
  void pokemonDelete();
  void pokemonInsert(PokemonVO vo);

  List<PokemonVO> getPokemonList(PokemonVO vo);
}
