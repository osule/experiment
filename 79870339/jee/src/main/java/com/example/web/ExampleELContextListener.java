package com.example.web;

import jakarta.el.ELContext;
import jakarta.el.ELContextEvent;
import jakarta.el.ELContextListener;
import jakarta.el.ImportHandler;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.jsp.JspFactory;

/**
 * ELContextListener that imports the com.example.web package for direct EL access.
 */
@WebListener
public class ExampleELContextListener implements ELContextListener, ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        JspFactory.getDefaultFactory()
                  .getJspApplicationContext(sce.getServletContext())
                  .addELContextListener(this);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Do nothing
    }

    @Override
    public void contextCreated(ELContextEvent event) {
        ELContext elContext = event.getELContext();
        ImportHandler importHandler = elContext.getImportHandler();

        if (importHandler != null) {
            importHandler.importPackage("com.example.web");
            // Can also be directly imported as:
            // importHandler.importClass("com.example.web.Suit");
        }
    }
}
