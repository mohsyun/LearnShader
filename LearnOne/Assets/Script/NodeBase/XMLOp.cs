using System.IO;
using System.Xml.Serialization;
using UnityEngine;

public class XMLOp
{
    public static void Serialize(object item, string path)
    {

 
        //FileInfo info = new FileInfo(path);

        //if (!info.Exists) //判断路径是否存在
        //{
        //    //不存在创建
        //    Debug.Log("路径不存在");
        //    return;
        //}


        XmlSerializer serializer = new XmlSerializer(item.GetType());
        StreamWriter writer = new StreamWriter(path);
        serializer.Serialize(writer.BaseStream, item);
        writer.Close();
    }

    public static T Deserialize<T>(string path)
    {
        XmlSerializer serializer = new XmlSerializer(typeof(T));
        StreamReader reader = new StreamReader(path);
        T deserialized = (T)serializer.Deserialize(reader.BaseStream);
        reader.Close();
        return deserialized;
    }
}