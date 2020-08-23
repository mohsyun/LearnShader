using System;
using System.Xml.Serialization;
using UnityEngine;

public enum ConnectionPointType { In, Out }

public class ConnectionPoint
{

    public string id;

    [XmlIgnore] public Rect rect;   //ConnectionPoint Rect

    [XmlIgnore] public ConnectionPointType type;  //ConnectionPoint 类型

    [XmlIgnore] public Node node;  //Node

    [XmlIgnore] public GUIStyle style;  //画布

    [XmlIgnore] public Action<ConnectionPoint> OnClickConnectionPoint;


    public ConnectionPoint() { }

    /// <summary>
    /// 初始化 ConnectionPoint
    /// </summary>
    /// <param name="node"></param>
    /// <param name="type"></param>
    /// <param name="style"></param>
    /// <param name="OnClickConnectionPoint"></param>
    public ConnectionPoint(Node node, ConnectionPointType type, GUIStyle style, Action<ConnectionPoint> OnClickConnectionPoint, string id = null)
    {
        this.node = node;
        this.type = type;
        this.style = style;
        this.OnClickConnectionPoint = OnClickConnectionPoint;
        rect = new Rect(0, 0, 10f, 20f);

        this.id = id ?? Guid.NewGuid().ToString();
    }

    /// <summary>
    /// 绘制点
    /// </summary>
    public void Draw()
    {
        rect.y = node.rect.y + (node.rect.height * 0.5f) - rect.height * 0.5f;

        switch (type)
        {
            //输入
            case ConnectionPointType.In:
                rect.x = node.rect.x - rect.width + 8f;
                break;
            //输出
            case ConnectionPointType.Out:
                rect.x = node.rect.x + node.rect.width - 8f;
                break;
        }

        if (GUI.Button(rect, "", style))
        {
            if (OnClickConnectionPoint != null)
            {
                OnClickConnectionPoint(this);
            }
        }
    }
}


