import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.Set;
import java.util.TreeSet;


public class dictionary
{
	public static void main(String arg[]) throws IOException
	{
				
		
		String test = new String(Files.readAllBytes(Paths.get("test")),StandardCharsets.UTF_8);
		String[] testArr = test.split("\n");
		Set<String> test_dictionary = new TreeSet<String>();
		int[] test_Y = new int[testArr.length];
		
	
		
		for(int i =0 ;i<testArr.length;i = i+1)
		{
//			System.out.println(testArr[i]);
			String[] lineArr=testArr[i].split(" ");
			for(int j = 2;j<lineArr.length;j=j+2)
			{
				test_dictionary.add(lineArr[j]);
			}
//			System.out.println(lineArr[1]);
			if(lineArr[1].equals("spam"))
			{
				test_Y[i] = 1;
			}
			else if(lineArr[1].equals("ham"))
			{
				test_Y[i] = -1;
			}

		}
		int[][] test_X = new int[testArr.length][test_dictionary.size()];
		
		System.out.println(test_dictionary);
		File test_features = new File("test_features.txt");
		FileWriter test_featureWriter = new FileWriter(test_features);
		test_featureWriter.write("");
		test_featureWriter = new FileWriter(test_features,true);
		
		File test_result = new File("test_result.txt");
		FileWriter test_resultWriter = new FileWriter(test_result);
		test_resultWriter.write("");
		test_resultWriter = new FileWriter(test_result,true);
		
		for(int i =0 ;i<testArr.length;i = i+1)
		{
//			System.out.println(testArr[i]);
			String[] lineArr=testArr[i].split(" ");
			
			for(int j = 2;j<lineArr.length;j=j+2)
			{
//				if(lineArr[j].equals("your"))
//					System.out.println(i+" your "+lineArr[j+1]+" "+Integer.parseInt(lineArr[j+1]));
				int index = Arrays.binarySearch(test_dictionary.toArray(), lineArr[j]);
				test_X[i][index] = Integer.parseInt(lineArr[j+1]);
//				if(lineArr[j].equals("your"))
//					System.out.println(i+" your "+lineArr[j+1]+" "+Integer.parseInt(lineArr[j+1])+ " "+test_X[i][index]);
				
			}
			
			for(int k=0;k<test_dictionary.size();k++)
			{
				test_featureWriter.write(test_X[i][k]+" ");	
			}
			
			test_featureWriter.write("\n");
			test_resultWriter.write(test_Y[i]+"\n");

		}
		
		test_featureWriter.close();
		test_resultWriter.close();
		
//		System.out.println(Arrays.binarySearch(test_dictionary.toArray(),"01"));
		System.out.println(test_dictionary.size());
		
		String train = new String(Files.readAllBytes(Paths.get("train-small")),StandardCharsets.UTF_8);
		String[] trainArr = train.split("\n");
//		Set<String> dictionary = new TreeSet<String>();
		int[] train_Y = new int[trainArr.length];
		
	
		
		for(int i =0 ;i<trainArr.length;i = i+1)
		{

			String[] lineArr=trainArr[i].split(" ");
			
//			System.out.println(lineArr[1]);
			if(lineArr[1].equals("spam"))
			{
				train_Y[i] = 1;
			}
			else if(lineArr[1].equals("ham"))
			{
				train_Y[i] = -1;
			}

		}
		int[][] train_X = new int[trainArr.length][test_dictionary.size()];
		
		System.out.println(test_dictionary);
		File features = new File("train_features.txt");
		FileWriter train_featureWriter = new FileWriter(features);
		train_featureWriter.write("");
		train_featureWriter = new FileWriter(features,true);
		
		File train_result = new File("train_result.txt");
		FileWriter resultWriter = new FileWriter(train_result);
		resultWriter.write("");
		resultWriter = new FileWriter(train_result,true);
		
		for(int i =0 ;i<trainArr.length;i = i+1)
		{
//			System.out.println(trainArr[i]);
			String[] lineArr=trainArr[i].split(" ");
			
			for(int j = 2;j<lineArr.length;j=j+2)
			{
//				if(lineArr[j].equals("your"))
//					System.out.println(i+" your "+lineArr[j+1]+" "+Integer.parseInt(lineArr[j+1]));
				int index = Arrays.binarySearch(test_dictionary.toArray(), lineArr[j]);
				train_X[i][index] = Integer.parseInt(lineArr[j+1]);
//				if(lineArr[j].equals("your"))
//					System.out.println(i+" your "+lineArr[j+1]+" "+Integer.parseInt(lineArr[j+1])+ " "+X[i][index]);
				
			}
			
			for(int k=0;k<test_dictionary.size();k++)
			{
				train_featureWriter.write(train_X[i][k]+" ");	
			}
			
			train_featureWriter.write("\n");
			resultWriter.write(train_Y[i]+"\n");

		}
		
		train_featureWriter.close();
		resultWriter.close();
		
//		System.out.println(Arrays.binarySearch(dictionary.toArray(),"01"));
		System.out.println(test_dictionary.size());

	}
}
