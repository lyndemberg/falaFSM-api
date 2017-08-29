package io.github.recursivejr.discenteVivo.dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import io.github.recursivejr.discenteVivo.factories.Conexao;
import io.github.recursivejr.discenteVivo.models.Curso;

public class CursoDaoPostgres implements CursoDaoInterface{
    private final Connection conn;

    public CursoDaoPostgres() throws SQLException, ClassNotFoundException {
        conn = Conexao.getConnection();
    }
    
    @Override
    public boolean adicionar(Curso curso) {
        String sql = "INSERT INTO Curso(nome) VALUES (?);";
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, curso.getNome());
            stmt.executeUpdate();
            stmt.close();
            conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
        return true;
    }

    @Override
    public boolean remover(Curso curso) {
        String sql = "DELETE FROM EnquetesCurso WHERE nomeCurso ILIKE " + curso.getNome() + "; " +
        				"DELETE FROM Curso WHERE nome ILIKE " + curso.getNome() + ";";
        try {
            Statement stmt = conn.createStatement();
            stmt.executeUpdate(sql);
            
            stmt.close();
            conn.close();
        } catch (SQLException ex) {
        	ex.printStackTrace(); 
        }
        return true;
    }

    @Override
    public List<Curso> listar() {
        List<Curso> cursos = new ArrayList<>();
        String sql = "SELECT * FROM Curso;";
        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while(rs.next()){
                Curso curso = new Curso();
                curso.setNome(rs.getString("nome"));
                
                EnqueteDaoPostgres enqueteDao = new EnqueteDaoPostgres();            	
                curso.setEnquetes(enqueteDao.enquetesPorCurso(curso.getNome()));
                
                cursos.add(curso);
            }
            stmt.close();
            conn.close();
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
        }
        return cursos;
    }

    @Override
    public Curso buscar(String nome) {
        String sql = "SELECT * FROM Curso WHERE nome ILIKE " + nome + ";";
        Curso curso = null;
        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            if(rs.next()){
                curso = new Curso();
                curso.setNome(rs.getString("nome"));
                
                EnqueteDaoPostgres enqueteDao = new EnqueteDaoPostgres();            	
                curso.setEnquetes(enqueteDao.enquetesPorCurso(curso.getNome()));
            }
            stmt.close();
            conn.close();
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
        }
        return curso;
    }

}
