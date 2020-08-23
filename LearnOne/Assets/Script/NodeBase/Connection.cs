using System;
using System.Xml.Serialization;
using UnityEditor;
using UnityEngine;

public class Connection
{
    public ConnectionPoint inPoint;  //输入点
    public ConnectionPoint outPoint;  //输出点
    [XmlIgnore] public Action<Connection> OnClickRemoveConnection;


    public Connection() { }

    /// <summary>
    /// 初始化 Connection
    /// </summary>
    /// <param name="inPoint"></param>
    /// <param name="outPoint"></param>
    /// <param name="OnClickRemoveConnection"></param>
    public Connection(ConnectionPoint inPoint, ConnectionPoint outPoint, Action<Connection> OnClickRemoveConnection)
    {
        this.inPoint = inPoint;
        this.outPoint = outPoint;
        this.OnClickRemoveConnection = OnClickRemoveConnection;
    }

    /// <summary>
    /// 绘制输入输出点
    /// </summary>
    public void Draw()
    {
        Handles.DrawBezier(
            inPoint.rect.center,
            outPoint.rect.center,
            inPoint.rect.center + Vector2.left * 50f,
            outPoint.rect.center - Vector2.left * 50f,
            Color.white,
            null,
            2f
        );

        //绘制线条
        if (Handles.Button((inPoint.rect.center + outPoint.rect.center) * 0.5f, Quaternion.identity, 4, 8, Handles.RectangleCap))
        {
            if (OnClickRemoveConnection != null)
            {
                OnClickRemoveConnection(this);
            }
        }
    }
}