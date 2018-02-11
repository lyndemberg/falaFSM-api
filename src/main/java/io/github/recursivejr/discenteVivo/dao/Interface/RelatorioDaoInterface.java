package io.github.recursivejr.discenteVivo.dao.Interface;

import io.github.recursivejr.discenteVivo.models.Relatorio;

public interface RelatorioDaoInterface {

	public Relatorio gerarRelatorio(String nomeEnquete);
	public Relatorio gerarRelatorio(int idEnquete);
}