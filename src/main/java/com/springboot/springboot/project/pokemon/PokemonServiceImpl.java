package com.springboot.springboot.project.pokemon;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PokemonServiceImpl implements PokemonService {

  @Autowired
  private PokemonDao dao;

  @Override
  public void pokemonDelete() {
    dao.pokemonDelete();
  }

  @Override
  public void pokemonInsert(PokemonVO vo) {
    dao.pokemonInsert(vo);
  }

  @Override
  public List<PokemonVO> getPokemonList(PokemonVO vo) {
    return dao.getPokemonList(vo);
  }

}
