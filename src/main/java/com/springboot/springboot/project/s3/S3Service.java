package com.springboot.springboot.project.s3;

import java.io.IOException;
import java.util.UUID;
import java.util.Arrays;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;

@Service
public class S3Service {
    private static final String DEFAULT_IMAGE_NAME = "https://travel-project-images.s3.ap-northeast-2.amazonaws.com/space.jpeg";

    @Autowired
    private S3Client s3Client;

    @Value("${cloud.aws.s3.bucket}")
    private String bucket;

    @Value("${cloud.aws.region.static}")
    private String region;

    public String upload(MultipartFile file, String dirName) throws IOException {
        String fileName = createFileName(file.getOriginalFilename());
        String filePath = dirName + "/" + fileName;

        PutObjectRequest putObjectRequest = PutObjectRequest.builder()
                .bucket(bucket)
                .key(filePath)
                .contentType(file.getContentType())
                .build();

        s3Client.putObject(putObjectRequest, RequestBody.fromInputStream(file.getInputStream(), file.getSize()));

        return String.format("https://%s.s3.%s.amazonaws.com/%s", bucket, region, filePath);
    }

    public String uploadDefaultImage(String dirName) {
        try {
            String fileName = DEFAULT_IMAGE_NAME;
            String filePath = dirName + "/" + fileName;

            PutObjectRequest putObjectRequest = PutObjectRequest.builder()
                    .bucket(bucket)
                    .key(filePath)
                    .contentType("image/jpeg")
                    .build();

            // 기본 이미지 파일을 S3에 업로드 (루트 디렉토리의 space.jpeg 사용)
            s3Client.putObject(putObjectRequest, RequestBody.fromFile(new java.io.File(DEFAULT_IMAGE_NAME)));

            return String.format("https://%s.s3.%s.amazonaws.com/%s", bucket, region, filePath);
        } catch (Exception e) {
            System.out.println("기본 이미지 업로드 실패: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    public void delete(String fileUrl) {
        try {
            // URL에서 파일 경로만 추출
            String filePath;
            if (fileUrl.startsWith("https://")) {
                // 전체 URL이 들어온 경우
                String[] parts = fileUrl.split("/");
                if (parts.length >= 4) {
                    // parts[3]부터 끝까지를 파일 경로로 사용
                    filePath = String.join("/", Arrays.copyOfRange(parts, 3, parts.length));
                    System.out.println("전체 URL에서 추출한 파일 경로: " + filePath);
                } else {
                    throw new IllegalArgumentException("잘못된 S3 URL 형식입니다: " + fileUrl);
                }
            } else {
                // 이미 파일 경로만 들어온 경우
                filePath = fileUrl;
                System.out.println("입력된 파일 경로: " + filePath);
            }
            
            DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder()
                    .bucket(bucket)
                    .key(filePath)
                    .build();

            s3Client.deleteObject(deleteObjectRequest);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private String createFileName(String originalFileName) {
        return UUID.randomUUID().toString() + getFileExtension(originalFileName);
    }

    private String getFileExtension(String fileName) {
        try {
            return fileName.substring(fileName.lastIndexOf("."));
        } catch (StringIndexOutOfBoundsException e) {
            throw new IllegalArgumentException("잘못된 형식의 파일입니다.");
        }
    }
} 