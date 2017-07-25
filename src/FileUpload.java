import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Collection;

/**
 * Created by Jack on 2017/7/25.
 */
@WebServlet("/upload.do")
@MultipartConfig
public class FileUpload extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String path = request.getServletContext().getRealPath("");
        response.setCharacterEncoding("utf-8");
        Collection<Part> files = request.getParts();
        for(Part file:files) {
            file.write(path+File.separator+file.getName());
        }
    }

}
