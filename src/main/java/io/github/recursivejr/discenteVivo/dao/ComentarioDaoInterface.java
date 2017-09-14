package io.github.recursivejr.discenteVivo.dao;

import io.github.recursivejr.discenteVivo.models.Comentario;

import java.util.List;

public interface ComentarioDaoInterface {

    public boolean adicionar(Comentario comentario);
    public boolean remover(Comentario comentario);
    public List<Comentario> listar();
    public List<Comentario> listarPorEnquete(int IdEnquete);
}