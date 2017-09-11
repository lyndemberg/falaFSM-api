package io.github.recursivejr.discenteVivo.infraSecurity;

import java.io.IOException;

import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.container.ContainerResponseContext;
import javax.ws.rs.container.ContainerResponseFilter;
import javax.ws.rs.core.MultivaluedMap;

public class CORSFilter implements ContainerResponseFilter {

	public void filter(ContainerRequestContext requestContext, ContainerResponseContext responseContext)
			throws IOException {

		MultivaluedMap<String, Object> headers = responseContext.getHeaders();

		headers.add("Access-Control-Allow-Origin", "*"); //Permite o Origin com qualquer URL
		//headers.add("Access-Control-Allow-Origin", "https://discente-vivo.herokuapp.com/");
		headers.add("Access-Control-Allow-Methods", "PUT, GET, POST, DELETE, OPTIONS");
        headers.add("Access-Control-Allow-Credentials", "true");
		headers.add("Access-Control-Allow-Headers", "X-Requested-With, Content-Type, X-Codingpedia");
	}

}